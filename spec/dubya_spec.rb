require 'spec_helper'

RSpec.describe Dubya do
  let :wiki do
    Wiki.new
  end

  let :mixlib do
    wiki.send :command
  end

  context 'when controlling the wiki files' do
    let :command do
      "cd #{app.send :wiki_path} && bundle exec rake update"
    end

    it 'computes the path to the public dir' do
      expect(wiki.path).to match(/public\Z/)
      expect(wiki).to be_exist
    end

    it 'builds the command to execute' do
      expect(mixlib).to be_a(Mixlib::ShellOut)
      expect(mixlib.command).to eq(command)
    end
  end

  context 'the POST route in the API' do
    let :response do
      last_response
    end

    let :json do
      JSON.parse response.body
    end

    before do
      allow(mixlib).to receive(:run_command).and_return nil
      allow(mixlib).to receive(:stdout).and_return 'stdout'
      allow(mixlib).to receive(:sterr).and_return 'stderr'
    end

    it 'updates the wiki when everything is ok' do
      allow(mixlib).to receive(:success?).and_return true
      post '/wiki'

      expect(response).to be_ok
      expect(response.status).to eq(200)
      expect(json.keys).to include('notice')
      expect(json['notice']).to eq('The wiki has been updated.')
    end

    it 'renders an http error if something goes wrong' do
      allow(mixlib).to receive(:success?).and_return false
      post '/wiki'

      expect(response).not_to be_ok
      expect(response.status).to eq(422)
      expect(json.keys).to include('alert')
      expect(json['alert']).to eq('Error updating wiki.')
      expect(json['errors']).to eq("stdout\n\nstderr")
    end
  end
end
